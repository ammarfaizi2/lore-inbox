Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVAKNIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVAKNIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 08:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVAKNHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 08:07:39 -0500
Received: from host234-143.pool8250.interbusiness.it ([82.50.143.234]:40321
	"EHLO zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S262752AbVAKNH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 08:07:26 -0500
Message-ID: <41E3CE5A.3000008@abinetworks.biz>
Date: Tue, 11 Jan 2005 14:02:18 +0100
From: "Ing. Gianluca Alberici" <alberici@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Nipper <nipsy@bitgnome.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bad disks or bug ?
References: <41E3C90A.2010703@abinetworks.biz> <20050111130005.GB87982@king.bitgnome.net>
In-Reply-To: <20050111130005.GB87982@king.bitgnome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Very Interesting news from Massimo...

About the heat source, Mark, i thought about that, too, and hdb is 
always the
bottom (CS Enabled) device of rackmounts (so the colder one) , in front
of the usual ball bearing fans !!!!

I am beginning to believe all this deserves a more deep investigation...

Waiting for comments,

Gianluca

Mark Nipper wrote:

>On 11 Jan 2005, Ing. Gianluca Alberici wrote:
>  
>
>>How do you explain that ? Overload on hdb due to mirroring and surface
>>degradation ?
>>OR a kind of vodoo on my hdbs ?
>>    
>>
>
>	Is it possible that hdb is closer to a high heat source
>or is not being cooled as hda if all these machines are the same
>case design?
>
>  
>
