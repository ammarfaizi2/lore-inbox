Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUAMAzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUAMAzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:55:14 -0500
Received: from vitelus.com ([64.81.243.207]:1741 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S263101AbUAMAzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:55:12 -0500
Date: Mon, 12 Jan 2004 16:54:56 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: psmouse synchronization loss under load
Message-ID: <20040113005456.GC2000@vitelus.com>
References: <20031220015131.GB9834@vitelus.com> <20031222183237.GA15844@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222183237.GA15844@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 01:32:37PM -0500, Pavel Machek wrote:
> Do you use ACPI? Using  APM made the error go away for me. 

No, I don't. I was also seeing abrupt poweroffs under load so I
cleaned out the ventilation paths inside the machine. This made
both problems go away. Probably a weird software or hardware reaction
to the heat.
