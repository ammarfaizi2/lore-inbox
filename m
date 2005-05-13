Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVEMH5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVEMH5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 03:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVEMH5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 03:57:07 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:52206 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262283AbVEMH5E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 03:57:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nLLRF4oFty5W/09VZ4ncZq8o0ncYHan7BK/a7Ke85IrXyuIBJwCoJzODHFl4v6MRgkrRoKun6hdMi+q9oXOSuAvvpLOJ4S3VpzCfYxa5vwuR1zxv4sYFEl3F2pQblCojJW1adYsuLf2zjskczbCA9bmIf7/O+h1IzIUfb9i+W9g=
Message-ID: <3cac075b0505130057466381e1@mail.gmail.com>
Date: Fri, 13 May 2005 12:57:03 +0500
From: Nauman <mailtonauman@gmail.com>
Reply-To: Nauman <mailtonauman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6 project compilation and GCC attribs??
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello, 
dudes i m using FC 3 with kdeveloper 3.0 on kernel 2.6. 
i have used quiet a few function pointers. but i have been
experiencing frustrating behaviour. there are some places in the code
where functions get called properly and on the other part they just
dont get called.

and on more thing 
when i use ( x < y ? 5:10)
with x=1 and y=2
the result i get is x = 10: ( 
and when i replace this stetement with if else struct i get correct result. 
y is this............ should i be coding my project or shoud i be
fixing those compilation bugs ..
what i need to ask is that is there any special gcc attributes which
are need to be specified, because i m using default make file to build
my project procuded by kdevelop's wizard.
whats wrong and where it can be........ 
i m terribly frustrated what do u guys thinkkkkkk

 
-- 
When the going gets tough, The tough gets going...!
Peace ,  
Nauman.
