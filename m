Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWCFP6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWCFP6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWCFP6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:58:55 -0500
Received: from cernmx08.cern.ch ([137.138.166.172]:62288 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1751823AbWCFP6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:58:54 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=QNMLNRaug8+iQ3KKD2jJJjntQprdg6DZR8seY1VJg3mHL7A8d/zfzyr6i+Otk325j3RFNX8MgEOA0XeR7Amftc8AcBkxmWVFg7mfAaqEV01UviCpSE2/Tef/2K0X2BE6;
Keywords: CERN SpamKiller Note: -51 Charset: west-latin
X-Filter: CERNMX08 CERN MX v2.0 051012.1312 Release
Message-ID: <440C5C41.2030409@cern.ch>
Date: Mon, 06 Mar 2006 16:58:57 +0100
From: Jiri Tyr <jiri.tyr@cern.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060128)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Sands <duncan.sands@math.u-psud.fr>
CC: linux-kernel@vger.kernel.org, mchehab@brturbo.com.br,
       video4linux-list@redhat.com
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
References: <440C5672.7000009@cern.ch> <200603061656.18846.duncan.sands@math.u-psud.fr>
In-Reply-To: <200603061656.18846.duncan.sands@math.u-psud.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2006 15:58:46.0981 (UTC) FILETIME=[DA19EF50:01C64136]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:

>>### [1.] One line summary of the problem:
>>Four PCI TV tuners based on bt878 chip in one PC crashed.
>>    
>>
>
>Are you using overlay, or grabdisplay?
>  
>
I'm using overlay on all tuners.

Jiri
