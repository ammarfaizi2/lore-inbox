Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVJTNLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVJTNLf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 09:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVJTNLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 09:11:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:26024 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932133AbVJTNLf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 09:11:35 -0400
Subject: Re: Reduce idle connection timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E1rcio?= Oliveira <moliveira@rhla.com>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <43553205.9010006@rhla.com>
References: <43553205.9010006@rhla.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 20 Oct 2005 14:40:01 +0100
Message-Id: <1129815601.15200.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-10-18 at 15:33 -0200, Márcio Oliveira wrote:
> Hi,
> 
>    Anybody knows how can I reduce the idle connections (TCP, UDP, ...) 
> timeout in Linux systems?

TCP timeout minimums are specified in the standard and we follow them
anyway. UDP has no "connection".


