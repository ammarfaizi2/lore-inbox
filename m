Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTI2AMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 20:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTI2AMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 20:12:18 -0400
Received: from codepoet.org ([166.70.99.138]:38074 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S261925AbTI2AMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 20:12:17 -0400
Date: Sun, 28 Sep 2003 18:12:17 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andrew Miklas <public@mikl.as>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linksys WRT54G: Part 2
Message-ID: <20030929001217.GA15576@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andrew Miklas <public@mikl.as>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200309281914.24869.public@mikl.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309281914.24869.public@mikl.as>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Sep 28, 2003 at 07:14:24PM -0400, Andrew Miklas wrote:
> Previously, it was thought that the WRT54G source releases had only
> neglected to include the source code for the various kernel modules
> used to run the ethernet and wireless interfaces.  However, at this
> time, it is clear that the kernel proper of the WRT54G itself has had
> functionality added to it.  This functionality is not present in the
> kernel code that Linksys has provided at their "GPL Code Center".

In addition, every program that links against libnetconf also
needs to have source released, as the libnetconf source is
apparently just parts ripped out from iptables....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
