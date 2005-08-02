Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVHBTbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVHBTbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 15:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVHBTbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 15:31:13 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:53479 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261726AbVHBTbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 15:31:12 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: Re: 2.6.13-rc5 - ACPI regression
Date: Tue, 2 Aug 2005 20:31:10 +0100
User-Agent: KMail/1.8.1
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       linux-kernel@vger.kernel.org
References: <20050802175336.GA2959@mail.muni.cz> <5a4c581d05080211595cc07fa3@mail.gmail.com> <20050802190526.GB2959@mail.muni.cz>
In-Reply-To: <20050802190526.GB2959@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508022031.10613.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 Aug 2005 20:05, Lukas Hejtmanek wrote:
[snip]
>
> I did not notice before, but my values (capacity and so on) are completely
> wrong. It should contain values in mWh instead of mAh.

mWh is mAh x operational voltage. They're not "completely wrong", probably 
just whatever unit your machine's ACPI uses.

The units are not the problem, it sounds like some other ACPI bug.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
