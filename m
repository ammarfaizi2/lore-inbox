Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314906AbSD2IiQ>; Mon, 29 Apr 2002 04:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314907AbSD2IiO>; Mon, 29 Apr 2002 04:38:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22543 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314906AbSD2IiL>; Mon, 29 Apr 2002 04:38:11 -0400
Date: Mon, 29 Apr 2002 09:38:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Soeren Sonnenburg <sonnenburg@informatik.hu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getting a programs ENV via ptrace ?
Message-ID: <20020429093804.A15259@flint.arm.linux.org.uk>
In-Reply-To: <1020068756.5050.7.camel@sun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 10:25:55AM +0200, Soeren Sonnenburg wrote:
> I am looking for a way of getting the environment variables of a running
> process.

/proc/<pid>/environ

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

