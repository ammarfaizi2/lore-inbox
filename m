Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267906AbUHEXO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267906AbUHEXO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267885AbUHEXO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:14:29 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:44701 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267790AbUHEXO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:14:26 -0400
Message-ID: <4112BF0A.3000807@rtr.ca>
Date: Thu, 05 Aug 2004 19:13:14 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: BUG: SCSI SYNCHRONIZE_CACHE on driver unload
References: <4112BC7A.1040102@rtr.ca> <20040805154826.633ff4cd.rddunlap@osdl.org>
In-Reply-To: <20040805154826.633ff4cd.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup.  That's the exact bug.
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
