Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVKGRIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVKGRIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVKGRIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:08:54 -0500
Received: from terminus.zytor.com ([192.83.249.54]:45292 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932300AbVKGRIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:08:53 -0500
Message-ID: <436F8A14.9070306@zytor.com>
Date: Mon, 07 Nov 2005 09:08:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Hengeveld <nickh@reactrix.com>
CC: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: GIT 0.99.9e
References: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net> <20051107154718.GJ3001@reactrix.com>
In-Reply-To: <20051107154718.GJ3001@reactrix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Hengeveld wrote:
> On Sun, Nov 06, 2005 at 09:43:19PM -0800, Junio C Hamano wrote:
> 
> 
>> - http-push seems to still have a bug or two but that is to be
>>   expected for any new code, and I am reasonably sure it can be
>>   ironed out; preferably before 1.0 but it is not a
>>   showstopper.
> 
> It seems like a minor point, but is this the appropriate name or should
> it be dav-push?  Not that there's anything else in the works AFAIK but
> it's certainly possible that something else could run over HTTP later
> on.
> 

Push over HTTP POST would at least be theoretically possible.

	-hpa
