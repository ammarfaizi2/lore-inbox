Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbUAYOXN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 09:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbUAYOXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 09:23:12 -0500
Received: from d213-103-156-147.cust.tele2.ch ([213.103.156.147]:49471 "EHLO
	kameha") by vger.kernel.org with ESMTP id S264300AbUAYOXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 09:23:11 -0500
Message-ID: <4013D155.3080900@freesurf.ch>
Date: Sun, 25 Jan 2004 15:23:17 +0100
From: Marc Mongenet <Marc.Mongenet@freesurf.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.25pre7 - cannot mount 128MB vfat fs on Minolta camera
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a Minolta DiMAGE F100 camera and two memory cards,
a 16 MB and a 128 MB.
With kernel 2.2.25 I can mount the 16 MB but not the 128 MB.
With kernel 2.4.16 to 2.4.25pre6 I can mount the 128 MB but not the 16 MB.
With kernel 2.4.25pre7 I can mount the 16 MB but not the 128 MB.

There is probably something special with the filesystem used by Minolta
because I have to format it with the camera to be recognized by the camera.

Marc Mongenet
