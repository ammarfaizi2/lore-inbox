Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWFTFJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWFTFJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWFTFJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:09:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:57551 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751151AbWFTFJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:09:26 -0400
Message-ID: <4497830B.5010402@163.com>
Date: Tue, 20 Jun 2006 13:09:31 +0800
From: Walkinair <walktodeath@163.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to get kernel source release from git tree?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this may be a stupid question, sorry for this.

I have kenel 2.6 git tree in my local box, usually through the following 
steps I get source release,
1. copy git repository to a new directory.
2. rm .git directory.
3. make config; make; make modules_install; make install

I there any convinient git command or other ways to get kernel release 
from git repository?

