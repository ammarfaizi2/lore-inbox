Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752240AbWCEMfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbWCEMfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 07:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbWCEMfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 07:35:16 -0500
Received: from pproxy.gmail.com ([64.233.166.183]:51960 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752240AbWCEMfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 07:35:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FUP/hh0G36NpM8GCbfIsA7GJEBpmbb6AfwSavwhWF2mJzyE3M4wk9cS1ekQ3KEfCkyLpoubx/E0qvElOlo/0q1ZhY3i5opFmXESfqGceHjgaCur27vaop9GH26P5kEzc488AZzgwqYxHyqnuQpIfVlrHbd9h7qm7QQPr618b90o=
Message-ID: <440ADAEA.8000308@gmail.com>
Date: Sun, 05 Mar 2006 20:34:50 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: gcoady@gmail.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm2
References: <20060303045651.1f3b55ec.akpm@osdl.org> <33rh02d65h18t6fo9j3reoaovd8kekjd88@4ax.com>
In-Reply-To: <33rh02d65h18t6fo9j3reoaovd8kekjd88@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> On Fri, 3 Mar 2006 04:56:51 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> 
> Enable firmware EDID (FB_FIRMWARE_EDID) [Y/n/?] (NEW)

The option is new, but the feature is old (2.5.x).  So as not to risk
breaking working setups, this needs to default to y.

Tony
