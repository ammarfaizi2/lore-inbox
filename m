Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUAJKI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 05:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUAJKI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 05:08:59 -0500
Received: from host127.ln.elender.hu ([212.108.222.127]:50816 "HELO
	kozakzs.office.eol.hu") by vger.kernel.org with SMTP
	id S265060AbUAJKI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 05:08:58 -0500
Message-ID: <3FFFCF37.90306@zsolt.net>
Date: Sat, 10 Jan 2004 11:08:55 +0100
From: Zsolt KOZAK <zsolt@zsolt.net>
Organization: Zsolt.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: reboot at uncompress kernel linux-2.6.0-test9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

navneet panda wrote:

 > I was trying to test the new kernel but it reboots the
 > moment it tries uncompress.

I also have this problem....

I had it with 2.6.0 and now I have this reboot with 2.6.1 also. I have a 
Pentium 4 CPU and this reboot occurs if I compile my kernel with this 
specific type of CPU only after "Uncompressing kernel..." message 
appears. If I compile it with Pentium3 support, it loads properly 
without reboot.

If I need to post any other information vabout my system, I'm happy to 
help you in solving my problem.

Please CC me, I'm off the list.

regard,
Zsolt


-- 
Zsolt KOZAK      zsolt@zso.lt
personal web:    http://zso.lt
Road To Avonlea: http://www.avonlea.hu


