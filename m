Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423605AbWKFITy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423605AbWKFITy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 03:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423604AbWKFITy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 03:19:54 -0500
Received: from mail.suse.de ([195.135.220.2]:42909 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423594AbWKFITx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 03:19:53 -0500
Date: Mon, 6 Nov 2006 09:19:27 +0100
From: Stefan Seyfried <seife@suse.de>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061106081927.GA9063@suse.de>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061105232944.GA23256@vasa.acc.umu.se>
X-Operating-System: openSUSE 10.2 (i586) Beta1plus, Kernel 2.6.18.1-13-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 12:29:44AM +0100, David Weinehall wrote:
> On Thu, Nov 02, 2006 at 05:54:03PM -0800, Kristen Carlson Accardi wrote:
> 
> > There is a bug here in that acpiphp shouldn't even be used on the X60 -
> > it has no hotpluggable slots.
> 
> How about the docking station?

Hm, i haven't seen one - i only saw the "media slice" (or however it is
called this week) which gives you a drive bay, but no additional PCI
devices, so it does not count.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
