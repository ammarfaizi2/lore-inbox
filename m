Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTJALei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 07:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTJALei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 07:34:38 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:36513 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262041AbTJALeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 07:34:37 -0400
From: johann lombardi <johann.lombardi@bull.net>
Reply-To: johann.lombardi@bull.net
Organization: BULL
To: ocsy@rusbiz.com, linux-kernel@vger.kernel.org
Subject: Re: How to use module in 2.6
Date: Wed, 1 Oct 2003 11:36:24 +0200
User-Agent: KMail/1.5.3
References: <1065006634.1144.39.camel@ocsy>
In-Reply-To: <1065006634.1144.39.camel@ocsy>
MIME-Version: 1.0
Message-Id: <200310011136.24176.johann.lombardi@bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 01/10/2003 13:37:45,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 01/10/2003 13:37:48,
	Serialize complete at 01/10/2003 13:37:48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 October 2003 13:10, ocsy wrote:
> Maybe i'm stuped but...
> I'can compile linux kernel 2.6.0.test4 and after reboot i can't use
> module))
> Can anybody help me to solve this problem!

Did you upgrade your module-init-tools (insmod, lsmod, ....) ?
(http://www.kernel.org/pub/linux/kernel/people/rusty/modules/)

Johann

