Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbTIMKd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 06:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbTIMKd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 06:33:58 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:52642 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S262121AbTIMKd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 06:33:57 -0400
Date: Sat, 13 Sep 2003 12:33:29 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Breno <brenosp@brasilsec.com.br>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Stack size
Message-ID: <20030913103329.GC1091@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Breno <brenosp@brasilsec.com.br>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <004801c390bd$55cca700$f8e4a7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004801c390bd$55cca700$f8e4a7c8@bsb.virtua.com.br>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Breno, Sun, Oct 12, 2003 14:35:33 +0200:
> What happen when stack increase more than 8mb ?

in the kernel or in a user program?

In user program - probably nothing.

