Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSENHhC>; Tue, 14 May 2002 03:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315258AbSENHhB>; Tue, 14 May 2002 03:37:01 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:59609 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S315257AbSENHhA>;
	Tue, 14 May 2002 03:37:00 -0400
Message-ID: <3CE0C17B.F5037970@2d3d.co.za>
Date: Tue, 14 May 2002 09:49:15 +0200
From: graeme fisher <graeme@2d3d.co.za>
Organization: 2d3d
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Nicolas.Aspert@epfl.ch
Subject: Re: Agpgart patch for the i845G
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas

The addresses are the same for the i830mp and i845g so instead of
duplicating the code I just used the i830 setup functions for the 845g
as well.

Strictly speaking the comment that you referred to in your mail should
be changed to reflect i845g and not i830mp.

Thanks for your comments

Graeme Fisher

