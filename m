Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVBGJAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVBGJAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 04:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVBGJAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 04:00:19 -0500
Received: from gwout.thalesgroup.com ([195.101.39.227]:62990 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S261371AbVBGJAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 04:00:15 -0500
Message-ID: <42072E13.4000903@fr.thalesgroup.com>
Date: Mon, 07 Feb 2005 10:00:03 +0100
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] support of motherboards with ICH6
References: <41FF9366.5030203@fr.thalesgroup.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am replying to myself so that people googling for similar problems can find 
the answer.

Supermicro says that the internal driver of the southbridge (and also the 
W83627HF chip) are not useable because the necessary support hardware is 
missing. They say that the P8SCi board has a working watchdog.

	hope this can help somebody someday,

	P.O. Gaillard


