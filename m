Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTIBSoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTIBSoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:44:19 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:58507 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261245AbTIBSoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:44:18 -0400
From: James Clark <jimwclark@ntlworld.com>
Reply-To: jimwclark@ntlworld.com
To: linux-kernel@vger.kernel.org
Subject: Driver Model
Date: Tue, 2 Sep 2003 19:43:15 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309021943.15875.jimwclark@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Will the move to a more uniform driver model in 2.6 increase the chances of 
a given binary driver working with a 2.6+ kernel. 

2. Will the new model reduce the use/need for kernel modules. Would this be a 
good thing if functionality could be implemented in a driver instead of a 
module.

3. Will the practice of deliberately breaking some binary only 'tainted' 
modules prevent take up of Linux. Isn't this taking things too far?

James
