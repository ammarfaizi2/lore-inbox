Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132046AbRCVOzA>; Thu, 22 Mar 2001 09:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132037AbRCVOyy>; Thu, 22 Mar 2001 09:54:54 -0500
Received: from mail.missioncriticallinux.com ([208.51.139.18]:60687 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S132044AbRCVOyp>; Thu, 22 Mar 2001 09:54:45 -0500
Message-ID: <3ABA11F3.60004@missioncriticallinux.com>
Date: Thu, 22 Mar 2001 09:53:39 -0500
From: "Patrick O'Rourke" <orourke@missioncriticallinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-pre6 i686; en-US; 0.8) Gecko/20010218
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:


> One question ... has the OOM killer ever selected init on
> anybody's system ?

Yes, which is why I created the patch.

-- 
Patrick O'Rourke
978.606.0236
orourke@missioncriticallinux.com

