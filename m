Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVAIQn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVAIQn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 11:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVAIQnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 11:43:25 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:22278 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261605AbVAIQnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 11:43:23 -0500
Message-ID: <41E15F09.70502@tuleriit.ee>
Date: Sun, 09 Jan 2005 18:42:49 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 0.8 (X11/20040923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mama Smurf <roseline.bonchamp@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: remove Attach another file remove Attach another file remove
 Attach another file USB mass storage not always detecting my 1GB PQI intelligent
 stick
References: <884a349a050109082516b0740e@mail.gmail.com>
In-Reply-To: <884a349a050109082516b0740e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mama Smurf wrote:

>Hello,
>
>my 1 GB PQI Intelligent Stick is often not beeing used by mass storage
>driver when I plug it.
>  
>

Do you have several different USB devices connected in the same time? It 
is possible that devices with different USB speed (high/full) cannot 
work together. I am not the kernel developer but this is just my 
experience with latest Linux distributions. The situation can be 
different with current USB developments.

regards,
Indrek

