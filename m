Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbUCNEam (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 23:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbUCNEal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 23:30:41 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:7766 "EHLO
	nebula.ghetto") by vger.kernel.org with ESMTP id S263277AbUCNEaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 23:30:39 -0500
Date: Sun, 14 Mar 2004 05:30:38 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: drivers/usb/class/usblp.c: usblp0: on fire
Message-ID: <20040314043037.GA1020@larroy.com>
Reply-To: piotr@larroy.com
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <pan.2004.03.14.03.35.52.138779@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.03.14.03.35.52.138779@triplehelix.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 07:35:53PM -0800, Joshua Kwan wrote:
> Hi,
> 
> $SUBJECT pretty much scared the hell out of me...
> 
> I noticed something fishy going on with USB in 2.6.4, maybe before. I am
> having lots of trouble printing using usblp. Once, I got the
> aforementioned message, and sometimes I get 
> 
> usb 2-1: control timeout on ep0in
> 
> Many times repeated. The bottom line is that I cannot print and I'm not
> sure whether it's something I forgot to configure after reinstalling this
> box, or something with the kernel. Could I be enlightented?
> 
> -- 
> Joshua Kwan
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


It happens the same to me in 2.6.4, seems to work in 2.6.3 and in 2.6.4-mm1

Regards.

-- 
Pedro Larroy Tovar | Linux & Network consultant |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
