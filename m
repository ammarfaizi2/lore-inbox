Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUCOWuq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbUCOWu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:50:28 -0500
Received: from law9-f89.law9.hotmail.com ([64.4.9.89]:50191 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262758AbUCOWtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:49:52 -0500
X-Originating-IP: [67.172.165.225]
X-Originating-Email: [sac98993@hotmail.com]
From: "Kevin Leung" <sac98993@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 15 Mar 2004 14:49:51 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law9-F89Xsn2Yf0scL90004e4c8@hotmail.com>
X-OriginalArrivalTime: 15 Mar 2004 22:49:51.0845 (UTC) FILETIME=[D3ABC150:01C40ADF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am very new to Linux and am working on a project. The nature of the 
project is to essentially record all process/thread scheduling activity for 
use in a later application. I wanted to know if any experts out there knew 
of any libraries that could essentially "monitor" or "listen" for any 
scheduling changes made. For instance if the kernel decides to set process A 
from "sleeping" to "running" and process B from "running" to "sleeping", I 
wanted to know if there was a function that could generate an immediate 
notification of this event. Priority change information is also desireable. 
The more aspects which trigger notificaiton, the better. As a first attempt, 
I tried understanding the source code of the system monitor application. I 
gained some insight, but still have questions. Mainly questions pertaining 
to how the system monitor application receives the most "up-to-the-minute" 
information on what process are running, what processes are sleeping etc. I 
got stuck in the code and decided to explore another means.  Any advice or 
insight into the matter would be greatly appreciated. If a library isn't 
available, does anyone know the difficulty involved if I tried to modify the 
kernel to provide this information?

Please CC me the comments and responses posted to the list in response to my 
posting

Thank You in advance

_________________________________________________________________
Frustrated with dial-up? Lightning-fast Internet access for as low as 
$29.95/month. http://click.atdmt.com/AVE/go/onm00200360ave/direct/01/

