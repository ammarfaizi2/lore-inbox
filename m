Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUJNXem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUJNXem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUJNXeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 19:34:04 -0400
Received: from CPE-203-51-28-190.nsw.bigpond.net.au ([203.51.28.190]:44531
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S267818AbUJNXbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 19:31:04 -0400
Message-ID: <416F0C32.2080802@eyal.emu.id.au>
Date: Fri, 15 Oct 2004 09:30:58 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6 smbfs warning
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.9 I see this warning logged
	smbfs: Unrecognized mount option noauto
and I thought that 'noauto' is a generic option
that is always supported in order to limit
	mount -a
invocations.

-- 
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
