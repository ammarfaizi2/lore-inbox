Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWHAWAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWHAWAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWHAWAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:00:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:60132 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751193AbWHAWAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:00:44 -0400
Message-ID: <44CFCF02.7080400@zytor.com>
Date: Tue, 01 Aug 2006 15:00:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: hardcode value of YACC&LEX for aic7-triple-x
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org> <20060729090725.GF6843@martell.zuzino.mipt.ru> <20060730193113.GB31690@mars.ravnborg.org>
In-Reply-To: <20060730193113.GB31690@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> Other places in kernel hardcode bison/flex so to be consistent aic7xxx
> does the same.

It would be better if this was centralized.

	-hpa
