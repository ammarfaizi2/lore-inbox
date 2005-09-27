Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbVI0Qrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVI0Qrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVI0Qrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:47:32 -0400
Received: from web51005.mail.yahoo.com ([206.190.38.136]:13991 "HELO
	web51005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964990AbVI0Qrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:47:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=yUSjwk4Xg9SaU1qAS6fIgXKuXF0o93XpjOPIdW33qpHCjTajK2F/mrtOwgBSzw6d3B0p/GuOpG3vyWn4K5q9sXAMwkNscK6z+IaVCT0Ym9GkH85DfT3pGJLV+XfqURdIrXKiG9bIeN5Odr3fKYpfBiyjvqjspw6lnPaM86hZvlA=  ;
Message-ID: <20050927164730.67368.qmail@web51005.mail.yahoo.com>
Date: Tue, 27 Sep 2005 09:47:30 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
To: Emmanuel Fleury <fleury@cs.aau.dk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <433941E0.7010005@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Well, the proc files are always here (it removes one
> requisite which is
> to have lspci installed). So, I would go for the
> proc files.

Proc files are not always on the system. As far as I
know you have to chose in the Kernl-Configuration.
And second of all I had some problem with a  debian
distrubotion. I dont know for what reason there was no
USB given in the /proc/... Files. But lspci did found 
it. And the Kernel was correctly configurated. I didnt
solved that problem. i just installed Kubuntu and
everybody was happy. For that reason I dont trust
/proc files anymore.

> Well, lspci is for PCI bus devices, it's already a
> lot, but not
> everything (that's why you need several
> scripts/methods to detect
> hardware, I guess).

Lspci do find other Hardware as well. Like USB,
Ethernet, ISA, Firewire...

Regards
Ahmad Reza Cheraghi

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
