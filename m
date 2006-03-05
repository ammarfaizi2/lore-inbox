Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWCEKSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWCEKSI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 05:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCEKSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 05:18:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14059 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751310AbWCEKSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 05:18:07 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: gregkh@kroah.com
In-Reply-To: <200601190414.k0J4EZCV021775@hera.kernel.org>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 11:18:04 +0100
Message-Id: <1141553885.16388.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +/* Main MC kobject release() function */
> +static void edac_memctrl_master_release(struct kobject *kobj)
> +{
> +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> +}
> +



ehhh how on earth can this be right?

