Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTLICqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 21:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTLICqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 21:46:04 -0500
Received: from CPE-65-30-34-80.kc.rr.com ([65.30.34.80]:39301 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S262564AbTLICqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 21:46:03 -0500
Message-ID: <3FD53769.10208@hanaden.com>
Date: Mon, 08 Dec 2003 20:46:01 -0600
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031204 Thunderbird/0.4RC1
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 java application memory usage
References: <3FD51FDC.30904@kc.rr.com>
In-Reply-To: <3FD51FDC.30904@kc.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.0-test11 and netbeans.org and tomcat under Java(TM) 2 
Runtime Environment, Standard Edition (build 1.4.2-b28) and havent seen 
anything remotely like this.

hemp4fuel wrote:
> I am running 2.6.0-test11 with a duron 1.3ghz with 630mb ram using 
> reiserfs and suns 1.4.2_01 jre, with 2.4.xx kernels the java based 
> application I run used around 35-50mb memory, with the 2.6.0-test11 it 
> goes right to 250mb and rises from there.  When I revert back to 2.4.23 
> it is back to 35-50mb memory usage.
> 
> Dustin
