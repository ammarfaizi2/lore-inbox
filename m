Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRBXH7n>; Sat, 24 Feb 2001 02:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbRBXH7d>; Sat, 24 Feb 2001 02:59:33 -0500
Received: from [202.106.186.237] ([202.106.186.237]:15310 "HELO email.com.cn")
	by vger.kernel.org with SMTP id <S129408AbRBXH7V>;
	Sat, 24 Feb 2001 02:59:21 -0500
Date: Sat, 24 Feb 2001 15:51:29 -0800
From: hugang <gang123@hu.com.cn>
To: patrick@spacesurfer.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with reiserfs
Message-Id: <20010224155129.2de4c72c.gang123@hu.com.cn>
In-Reply-To: <3A967D27.803F4C8F@spacesurfer.com>
In-Reply-To: <3A967D27.803F4C8F@spacesurfer.com>
X-Mailer: Sylpheed version 0.4.61 (GTK+ 1.2.8; Linux 2.4.1; i686)
Organization: soul
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mackinlay :
	
	If your use redhat 7.0 ;Your will check the kernel "Makefile" ,change the gcc to kgcc , Try again !
Update the gcc from http://www.redhat.com/

>00000000 <_EIP>:
>Code;  d2cf9db8 <[reiserfs]create_virtual_node+298/490>   <=====
>   0:   8b 40 14                  mov    0x14(%eax),%eax   <=====
>Code;  d2cf9dbb <[reiserfs]create_virtual_node+29b/490>	
>   3:   ff d0                     call   *%eax								<------------------------ *eax ==0 
>Code;  d2cf9dbd <[reiserfs]create_virtual_node+29d/490>


-- 
--------------------------------------------------------------------
                       Hu  Gang 
--------------------------------------------------------------------
Email	: linuxbest@sina.com,linuxhappy@tang.com,gang_hu@soul.com.cn 
Comany  : China Beijing Soul
Phone   : +860168425741~~44
MP	: 13601394711
--------------------------------------------------------------------
Linux Reigstered User ID 	#204016
--------------------------------------------------------------------
