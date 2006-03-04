Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWCDRP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWCDRP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWCDRP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:15:26 -0500
Received: from mail.dvmed.net ([216.237.124.58]:50094 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932210AbWCDRPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:15:24 -0500
Message-ID: <4409CB1C.7060201@pobox.com>
Date: Sat, 04 Mar 2006 12:15:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Brown <broonie@sirena.org.uk>
CC: Tim Hockin <thockin@hockin.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] natsemi: NAPI and a bugfix
References: <20060202233909.426660000@lorien.sirena.org.uk> <20060202235155.775450000@lorien.sirena.org.uk>
In-Reply-To: <20060202235155.775450000@lorien.sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown wrote:
> This patch converts the natsemi driver to use NAPI.  It was originally
> based on one written by Harald Welte, though it has since been modified
> quite a bit, most extensively in order to remove the ability to disable
> NAPI since none of the other drivers seem to provide that functionality
> any more.
> 
> Signed-off-by: Mark Brown <broonie@sirena.org.uk>

applied 1-2


