Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbSKOKRx>; Fri, 15 Nov 2002 05:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbSKOKRx>; Fri, 15 Nov 2002 05:17:53 -0500
Received: from h209.dkm.cz ([62.24.73.209]:4113 "EHLO gw.wawanet.cz")
	by vger.kernel.org with ESMTP id <S265987AbSKOKRx>;
	Fri, 15 Nov 2002 05:17:53 -0500
Message-ID: <3DD4CB81.1050704@bouska.cz>
Date: Fri, 15 Nov 2002 11:25:05 +0100
From: Richard Bouska <richard@bouska.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS mountned  directory  and apache2 (2.5.47)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
In 2.45.47 and 2.5.46 (at least) did not try any other am I not able to 
serve files bigger than 255 bytes by apache2 from nfs mounted directory. 
The local files are served correctly.
The server is on 2.4.18. When I use the 2.4 also on client everything 
works. When the content of the page is CGI generated then the size is 
not limited like this.
Both client and server are x86 (athlon)
kernel compiled with: gcc version 2.95.4 20011002 (Debian prerelease)

sendfile() bug ??

Any ideas
Richard Bouska


