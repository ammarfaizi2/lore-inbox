Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbVLGSoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbVLGSoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbVLGSoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:44:05 -0500
Received: from intranet.networkstreaming.com ([24.227.179.66]:42589 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S1751741AbVLGSoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:44:04 -0500
Message-ID: <43972D70.9040005@davyandbeth.com>
Date: Wed, 07 Dec 2005 12:44:00 -0600
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: config question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2005 18:44:18.0153 (UTC) FILETIME=[3AC6C590:01C5FB5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question: 

What is the danger or disadvantage (if any) of setting:

CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y

when a machine only has say 512megs installed?


Thanks,
  Davy
