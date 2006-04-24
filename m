Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWDXPKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWDXPKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDXPKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:10:37 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:7607 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750905AbWDXPKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:10:36 -0400
Date: Mon, 24 Apr 2006 16:10:26 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: dtor_core@ameritech.net
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060424151026.GB21096@srcf.ucam.org>
References: <20060419195356.GA24122@srcf.ucam.org> <20060419200447.GA2459@isilmar.linta.de> <20060419202421.GA24318@srcf.ucam.org> <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 10:45:31AM -0400, Dmitry Torokhov wrote:

> Matthew, I would recommend not adding KEY_LID but using one of the
> switch codes (SW_0?) for the lid.

Ok, sounds good. I'll wait to see which one seems most preferable.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
