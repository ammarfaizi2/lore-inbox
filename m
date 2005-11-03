Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVKCWCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVKCWCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVKCWCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:02:47 -0500
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:41370 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751152AbVKCWCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:02:47 -0500
Message-ID: <436A892B.9080806@austin.rr.com>
Date: Thu, 03 Nov 2005 16:03:23 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: recommended sparse checks on kernel code
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there other interesting/useful sparse checks that can be done beyond
    make C=2 -Wbitwise
for kernel code?  Is that the maximum checks that sparse can do without 
hacking it up?
