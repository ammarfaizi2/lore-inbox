Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbTACAYQ>; Thu, 2 Jan 2003 19:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTACAYP>; Thu, 2 Jan 2003 19:24:15 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:34066 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267349AbTACAYP>; Thu, 2 Jan 2003 19:24:15 -0500
Date: Fri, 3 Jan 2003 00:32:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: __NR_exit_group for 2.4-O(1)
Message-ID: <20030103003244.A10586@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030103001522.GA1539@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030103001522.GA1539@werewolf.able.es>; from jamagallon@able.es on Fri, Jan 03, 2003 at 01:15:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 01:15:22AM +0100, J.A. Magallon wrote:
> Hi all...
> 
> I am running glibc-2.3.1 on top of a hacked 2.4.21-pre2+aa, and all programs
> show a curious message at exit when straced:

Maybe it would be a better idea to complain to the glibc folks?

Your libc isn't the one from RH's new beta, is it? :)

