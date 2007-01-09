Return-Path: <linux-kernel-owner+w=401wt.eu-S1750830AbXAIBey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbXAIBey (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 20:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXAIBey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 20:34:54 -0500
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:48367 "HELO
	smtp101.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750830AbXAIBex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 20:34:53 -0500
X-YMail-OSG: 2zDV0VYVM1l9VRefV.l2b_t4tCdLcozGvdSHhWHUQadJ33d01QmmTbI0wK8fWud19hR216LPAjUPAmv9IJunwteMx2a37iflcojbyhmIRdRMNhfRGigkEZbCUM2g6CSjJYJ6sUwPjJ.CIiuL6mf1opprhxMQE4fGX6msTuEm36HNtSjEIsJNlyRDqOwD
Message-ID: <45A2F218.8010608@metricsystems.com>
Date: Mon, 08 Jan 2007 17:38:32 -0800
From: John Clark <jclark@metricsystems.com>
Organization: Metric Systems, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@lina.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange ethN numbering problem.
References: <E1H45al-0002Xj-00@calista.eckenfels.net>
In-Reply-To: <E1H45al-0002Xj-00@calista.eckenfels.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels schrieb:
> In article <45A2E19F.4070307@metricsystems.com> you wrote:
>   
>> However, when the system comes up and attempt to do an ifconfig, the 
>> 'ethN' numbers
>> have changed to a some what intermengled seriese starting with eth6... 
>> eth10.
>>     
>
> maybe a system startup script is renaming them (in order to give them well
> known numbers)? 
>
> What kind of distribution is that? is this a new problem? Have a look in
> /etc/mactab.

This is not a 'new' distribtution. In fact, the disk was used for a 
previous hardware box, of the same
manufacturer and allegedly the same cpu mother board.

The kernel is 2.6.19.1 the at-that-moment current linux kernel.

What should I look for in terms of interface renaming. What is also sort 
of strange is that they all
have the same 'mac' address vendor unique id... even though two 
interfaces are for an Intel
ethernet chip, and the othe 4 are from the Marvel chip.

Thanks
John Clark

