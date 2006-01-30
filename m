Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWA3SqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWA3SqG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWA3SqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:46:06 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:19260 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964862AbWA3SqE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:46:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O5CnT8ue0bsBFymhE7ifYBjgYCdM9UmcTxzz4xnuSY3ks4qfgXkvGZ16DJtBm8I+zPHoWIOap2Gp9TF0gg7V49WdgRIkW7n/31U1m7oB/8AZOPKaQvWMU3dOvleZuco0Rdzv2tYtLw8/VaiL888TT+7hvUVJvsqFAjnZdy7uL+g=
Message-ID: <56a8daef0601301046w37ecf5c0s93b906c7d971e272@mail.gmail.com>
Date: Mon, 30 Jan 2006 10:46:04 -0800
From: John Ronciak <john.ronciak@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/net/e1000/: proper prototypes
Cc: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060130172047.GB3655@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060130172047.GB3655@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ACK this patch.

Jeff please apply.

--
Cheers,
John
