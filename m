Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTIUVRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 17:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTIUVRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 17:17:43 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:58309 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S262567AbTIUVRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 17:17:43 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: Re: Broken synaptics mouse..
Date: Sun, 21 Sep 2003 23:17:40 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309212317.40703.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> linux-petero/drivers/input/mouse/synaptics.c | 68 +++++++++++------- 
>> linux-petero/drivers/input/mousedev.c | 100 +++++++++++++++++++-------- 
>> linux-petero/include/linux/input.h | 3 3 files changed, 118 
>> insertions(+), 53 deletions(-)
>
> Yes, this now looks very nice. Applied.

Which patches are required to test it? (it can't be applied to -bk8).
 

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

