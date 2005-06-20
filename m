Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVFTSx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVFTSx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVFTSxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:53:55 -0400
Received: from mail.linicks.net ([217.204.244.146]:33034 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261456AbVFTSxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:53:37 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org, guorke <gourke@gmail.com>
Subject: Re: mabye simple,but i confused
Date: Mon, 20 Jun 2005 19:53:19 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201953.19827.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

guorke wrote:

> Thanks,I must read it carefully
> 
> On 6/16/05, Richard B. Johnson <linux-os@analogic.com> wrote:
>> On Thu, 16 Jun 2005, guorke wrote:
>> 
>> > in understangding the linux kernel, the authors says
>> > "..Moves itself from address 0x00007c00 to address 0x00090000.."
>> >
>> > What i confused is why the Boot Loader do this, i asked google,but
>> > still no answe.
>> > who can make me understand it ?
>> > Thanks.
>> 
>> The IBM 'IPL' (initial program load) address was specified to be
>> at 7c00. There was room here for only one "sector", which in the
>> early days was 512 bytes....

There is more in Documentation/i386/boot.txt on this subject.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
