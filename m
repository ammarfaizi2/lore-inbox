Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWCQQuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWCQQuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWCQQuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:50:18 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:60886 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751432AbWCQQuQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:50:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R4GJtb82r/EPLbmMGoL9gdMvC6hyeBhjI6EBF+DBX6ZR1ATB8Ukd/3xP33tuL4da4emAuFJknNsmtPvsvbNyv+fVa4fI4CVe/rlG3QJEMlfojm2J4/xG3Jg369SAAVPn/Zy4wVOxX6u1q+uLetUSwDNG5O6+fLYQ5u88lTurGpw=
Message-ID: <6bffcb0e0603170850i5f955151v@mail.gmail.com>
Date: Fri, 17 Mar 2006 17:50:15 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: [Patch 0/8] Port of -fstack-protector to the kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1142611850.3033.100.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/03/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> This patch series adds support for the gcc 4.1 -fstack-protector feature to
> the kernel. Unfortunately this needs a gcc patch before it can work, so at
> this point these patches are just for comment, not for merging.
>

It's x86_64 specific?

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
