Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263190AbSJCI0t>; Thu, 3 Oct 2002 04:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbSJCI0t>; Thu, 3 Oct 2002 04:26:49 -0400
Received: from k100-28.bas1.dbn.dublin.eircom.net ([159.134.100.28]:274 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S263190AbSJCI0t>;
	Thu, 3 Oct 2002 04:26:49 -0400
Message-ID: <3D9C004A.3080006@corvil.com>
Date: Thu, 03 Oct 2002 09:31:06 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OT] backtrace
References: <Pine.LNX.4.44.0210021112020.6201-100000@localhost.localdomain> <E17wmTG-0001Zn-00@starship>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Wednesday 02 October 2002 11:22, Ingo Molnar wrote:
> 
>>The attached (tested) patch modifies x86's dump_stack() to print out the
>>much friendlier backtrace.
> 
> How about calling it backtrace(), since that's now what it is.

Sorry to go off topic but this tip is just too useful IMHO.
You can do the same in userspace with glibc. Details here:
http://www.iol.ie/~padraiga/backtrace.c

Pádraig.

