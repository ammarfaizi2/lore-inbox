Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTE2UXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTE2UXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:23:33 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:53843 "EHLO
	arlx248.austin.ibm.com") by vger.kernel.org with ESMTP
	id S262623AbTE2UXd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:23:33 -0400
Subject: Re: Memory page references
From: Wes Felter <wmf@austin.ibm.com>
To: =?ISO-8859-1?Q?Cs=E1rdi_G=E1bor?= <csardi@rmki.kfki.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030529210007.E16598@bifur.rmki.kfki.hu>
References: <20030529210007.E16598@bifur.rmki.kfki.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: IBM Austin Research Lab
Message-Id: <1054240587.7626.1.camel@arlx248.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 29 May 2003 15:36:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-29 at 14:00, Csárdi Gábor wrote:
> Hello,
> 
> I'd like to extract the (virtual) memory page sequences
> referenced by a given process. Do you have any idea how I could
> manage this? Is it possible at least? I have i386 hardware, if
> this is important...
> 
> (I intend to study the behaviour of programs corncerning memory
> usage, eg. their typical reference sequences (if any).)

Check out VMTrace from UT Austin:

http://www.cs.utexas.edu/users/oops/compressed-caching/

-- 
Wes Felter
Power-Aware Systems Department
IBM Austin Research Lab
11400 Burnet Road, Austin, TX 78758
Tel 512-838-7933
