Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVGLNng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVGLNng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVGLNmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:42:14 -0400
Received: from titan.solar.com.br ([200.199.212.42]:27290 "HELO
	titan.solar.com.br") by vger.kernel.org with SMTP id S261435AbVGLNkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:40:33 -0400
Message-ID: <42D3C6C4.3030808@ztec.com.br>
Date: Tue, 12 Jul 2005 10:33:56 -0300
From: sauro <sauro@ztec.com.br>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: STDOUT to shell command
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I have an application that throuws some debug on STDOUT. Then, all of a 
sudden, some characters miss and the debug messages in STDOUT start to 
be treated as if they were shell commands! I read that in Linux, there's 
a non-printable character that "tells" STDOUT to handle its data as 
commands, but I'm not sure...
Has anyone faced this behavior before? Is it "normal"?

Thanks in advance

-- 
Sauro Salomoni

Engineer
Ztec
www.ztec.com.br

