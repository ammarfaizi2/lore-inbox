Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWEYVei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWEYVei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWEYVei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:34:38 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14262 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030432AbWEYVeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:34:37 -0400
Message-ID: <447622EA.90704@garzik.org>
Date: Thu, 25 May 2006 17:34:34 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: devmazumdar <dev@opensound.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
References: <e55715+usls@eGroups.com>
In-Reply-To: <e55715+usls@eGroups.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.3 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


find / -name libata-scsi.c


