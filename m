Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVCPQPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVCPQPO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVCPQPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:15:13 -0500
Received: from baikonur.stro.at ([213.239.196.228]:2465 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S262666AbVCPQPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:15:09 -0500
Date: Wed, 16 Mar 2005 17:15:03 +0100
From: maximilian attems <janitor@sternwelten.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: Re: 2.6.11-mm4
Message-ID: <20050316161503.GB2410@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316040654.62881834.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>+w6692-eliminate-bad-section-references.patch

thanks for updating the patch.
the txt has still the old content, please change it to:

added __init to W6692Version().

--
maks

