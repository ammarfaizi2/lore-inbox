Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVA2U5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVA2U5N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 15:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVA2U5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 15:57:13 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:53666 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261559AbVA2U5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 15:57:10 -0500
Message-ID: <41FBF8A0.6000708@comcast.net>
Date: Sat, 29 Jan 2005 15:57:04 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
CC: Lee Revell <rlrevell@joe-job.com>, Jon Smirl <jonsmirl@gmail.com>,
       ee21rh@surrey.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: OpenOffice crashes due to incorrect access permissions on /dev/dri/card*
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk> <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net> <pan.2005.01.29.12.49.13.177016@surrey.ac.uk> <pan.2005.01.29.13.02.51.478976@surrey.ac.uk> <9e473391050129112525f4947@mail.gmail.com> <1107030966.24676.28.camel@krustophenia.net> <20050129204036.GA1750@gallifrey>
In-Reply-To: <20050129204036.GA1750@gallifrey>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dr. David Alan Gilbert wrote:

>* Lee Revell (rlrevell@joe-job.com) wrote:
>  
>
>>Stupid question: what the heck does OO use DRI for?  I googled and came
>>up empty.
>>    
>>
>
>It does pointless 3D objects in its drawing package.
>  
>
Another stupid question :)
Does it mean DRI is only used for doing 3D? How about normal, 2D stuff? 
I thought X uses DRI for both 2D  and 3D if it is available...
