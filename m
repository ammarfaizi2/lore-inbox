Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWBJIHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWBJIHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 03:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWBJIHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 03:07:06 -0500
Received: from ns2.suse.de ([195.135.220.15]:27592 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751185AbWBJIHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 03:07:05 -0500
Date: Fri, 10 Feb 2006 09:06:43 +0100
From: Stefan Seyfried <seife@suse.de>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060210080643.GA14763@suse.de>
References: <20060208125753.GA25562@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060208125753.GA25562@srcf.ucam.org>
X-Operating-System: SUSE LINUX 10.0.42 (i586) OSS Beta3, Kernel 2.6.16-rc2-git2-20060207172906-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 12:57:53PM +0000, Matthew Garrett wrote:
> The included patch adds support for power management methods to register 
> callbacks in order to allow drivers to check if the system is on AC or 
> not. Following patches add support to ACPI and APM. Feedback welcome.

Ok. Maybe i am not seeing the point. But why do we need this in the kernel?
Can't we handles this easily in userspace?
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
