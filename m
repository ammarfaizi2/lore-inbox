Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVAEOSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVAEOSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVAEOSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:18:35 -0500
Received: from cpc2-colc3-4-0-cust236.colc.cable.ntl.com ([81.107.32.236]:25256
	"EHLO sofa.co.uk") by vger.kernel.org with ESMTP id S262440AbVAEOSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:18:33 -0500
Subject: Re: PROBLEM: 2.6.10 oops on startup
From: Paul Bain <prbain@essex.ac.uk>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <2cd57c9005010422241a1e36da@mail.gmail.com>
References: <1104605177.6137.92.camel@sofa.co.uk>
	 <41DAE494.1020807@osdl.org> <1104899778.1992.45.camel@sofa.co.uk>
	 <2cd57c9005010422241a1e36da@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104934699.1652.49.camel@sofa.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 Jan 2005 14:18:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 06:24, Coywolf Qi Hunt wrote:
> This is a quick fix. Please try the attached patch.
> 
> 
>  coywolf
> 

Still gives the same oops, but now I get a new message during ACPI
initialization:
acpi-thermal-0400 [11] acpi_thermal_get_trip_: invalid active threshold
[0]

-- 
Paul Bain <prbain@essex.ac.uk>
