Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbSKLUdb>; Tue, 12 Nov 2002 15:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbSKLUdb>; Tue, 12 Nov 2002 15:33:31 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:30735
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266941AbSKLUca>; Tue, 12 Nov 2002 15:32:30 -0500
Subject: Re: [PATCH] module_name()
From: Robert Love <rml@tech9.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021112174741.6073E2C2B2@lists.samba.org>
References: <20021112174741.6073E2C2B2@lists.samba.org>
Content-Type: text/plain
Organization: 
Message-Id: <1037133554.2794.18.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Nov 2002 15:39:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 12:32, Rusty Russell wrote:

> +static inline char *module_name(struct module *module)
> +{
> +	Return "[built-in]";
> +}

s/Return/return/ ? ;-)

	Robert Love

