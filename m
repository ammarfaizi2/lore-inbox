Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270097AbTHSKjU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270142AbTHSKjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:39:20 -0400
Received: from westhill.hyglo.com ([62.119.43.37]:62864 "EHLO
	westhill.hyglo.com") by vger.kernel.org with ESMTP id S270097AbTHSKjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:39:19 -0400
Message-ID: <3F41FE52.3000109@hyglo.com>
Date: Tue, 19 Aug 2003 12:39:14 +0200
From: peter enderborg <pme@hyglo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: strtok non reentrant
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2003 10:39:18.0275 (UTC) FILETIME=[247E0530:01C3663E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why do the 2.4 kernel having the non reentrant strtok() functions?  Is 
there any reason at all not to have
strtok_r() instead?

