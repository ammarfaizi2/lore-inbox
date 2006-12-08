Return-Path: <linux-kernel-owner+w=401wt.eu-S1759660AbWLHNtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759660AbWLHNtH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 08:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759667AbWLHNtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 08:49:07 -0500
Received: from smtp.nokia.com ([131.228.20.170]:62218 "EHLO
	mgw-ext11.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759660AbWLHNtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 08:49:04 -0500
Message-ID: <45796CF9.3050702@yandex.ru>
Date: Fri, 08 Dec 2006 15:47:37 +0200
From: Artem Bityutskiy <dedekind@yandex.ru>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: -mm tree and git
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Dec 2006 13:47:44.0420 (UTC) FILETIME=[70131640:01C71ACF]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew, community,

I am not really aware how your -mm tree cooperates with git so I have 
questions.

Actually I am talking about the "git-ubi.patch" in your tree. You seems 
to periodically update the patch by fetching the stuff from the 
ubi-2.6.git GIT tree.

1. How do you produce the diff file from the ubi-2.6.git?
2. Do you mind if I re-base the ubi-2.6.git from time to time? Does it 
cause any troubles for you?
3, Are there some special things I should or should not do to make it 
easy for you to work with the git tree?
4. I see a 
"ubi-versus-add-include-linux-freezerh-and-move-definitions-from.patch" 
patch in your tree. It is related to the stuff which is available in 
Linus's tree. But my tree does not have it yet. Is is OK if I won't push 
it for now and do this later when I sync with mainline?

Thanks.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
