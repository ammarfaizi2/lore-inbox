Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVANSUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVANSUo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVANSUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:20:44 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:29446 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261279AbVANSTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:19:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=gFuMqLx8s8ii4I4t+j5VO3o8JIbwwmKAmIf+iv85OQMYeqnbnFQydEAyr6sLHY1aOs/tmzROhdfPpqIbtiSiUYSUFkeyh2skNO/RtQn190uWIpkuBcgD8cqAVBYD1sFJPXPOa3O4u/3jvyQMtcUmfxhIca2ccBfSkVKzyVqkziQ=
Message-ID: <3cac075b050114101944a14649@mail.gmail.com>
Date: Fri, 14 Jan 2005 10:19:17 -0800
From: Nauman <mailtonauman@gmail.com>
Reply-To: Nauman <mailtonauman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: parallel SCSI command excution........ any idea?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.....
I have been reading some SCSI Transport protocol layer services. i
dont have any idea about how m i going to be doing this but i want to
implement SCSI Target and SCSI Initiator driver for Qlogic's HBA.
While i m studying to get the grasp of the related issues .......... ,
can any body give me idea about parallel command execution from
initiator to target because i have read that commands have to be
processed sequentially. what to do if i need maximum speed with
parallel execution.
 I may sound abstract but if some one thinks that he can help then i m
anxious....


-- 
When the going gets tough, The tough gets going...!
Peace ,  
Nauman Tahir.
