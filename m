Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbSLDVTD>; Wed, 4 Dec 2002 16:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbSLDVTD>; Wed, 4 Dec 2002 16:19:03 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:28179 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267090AbSLDVTD>; Wed, 4 Dec 2002 16:19:03 -0500
Date: Wed, 4 Dec 2002 22:26:29 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Shawn Starr <shawn.starr@datawire.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.50, ACPI] link error
In-Reply-To: <200212041605.11935.shawn.starr@datawire.net>
Message-ID: <Pine.LNX.4.44.0212042223270.2109-100000@serv>
References: <200212041605.11935.shawn.starr@datawire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Dec 2002, Shawn Starr wrote:

> Thats what I thought until Pavel told me SOFTWARE_SUSPEND requires ACPI_SLEEP 
> and ACPI_SLEEP should not be unchecked if SOFTWARE_SUSPEND is disabled.

Is there then any reason to ask the user for ACPI_SLEEP?

bye, Roman

