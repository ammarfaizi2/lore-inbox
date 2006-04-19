Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWDSUEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWDSUEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWDSUEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:04:50 -0400
Received: from isilmar.linta.de ([213.239.214.66]:7581 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751217AbWDSUEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:04:49 -0400
Date: Wed, 19 Apr 2006 22:04:47 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060419200447.GA2459@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060419195356.GA24122@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419195356.GA24122@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 08:53:58PM +0100, Matthew Garrett wrote:
> +++ a/include/linux/input.h	2006-04-19 20:49:18 +0100
> @@ -344,6 +344,7 @@
>  #define KEY_FORWARDMAIL		233
>  #define KEY_SAVE		234
>  #define KEY_DOCUMENTS		235
> +#define KEY_LID			237

What about 236?

	Dominik
