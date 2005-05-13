Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVEMOjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVEMOjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVEMOjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:39:33 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:1179 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262389AbVEMOhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:37:11 -0400
Message-ID: <4284BB93.5080203@freenet.de>
Date: Fri, 13 May 2005 16:37:07 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cotte@freenet.de
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 3/5] ext2: add execute in place support
References: <428216FF.2010909@de.ibm.com>
In-Reply-To: <428216FF.2010909@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otte wrote:

>[RFC/PATCH 3/5] ext2: add execute in place support
>  
>
This patch does'nt compile without CONFIG_FS_XIP. Sorry. => fixed in
next version
