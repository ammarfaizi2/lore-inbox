Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286615AbSABB1V>; Tue, 1 Jan 2002 20:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286529AbSABB1G>; Tue, 1 Jan 2002 20:27:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40710 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286502AbSABBZK>; Tue, 1 Jan 2002 20:25:10 -0500
Message-ID: <3C326162.8080108@zytor.com>
Date: Tue, 01 Jan 2002 17:24:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <0GPA00BK988OBK@mtaout45-01.icomcast.net> <Pine.LNX.4.10.10201011521190.6558-100000@master.linux-ide.org> <a0tlji$e5m$1@cesium.transmeta.com> <20020101201950.A11644@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

> On Tue, Jan 01, 2002 at 04:52:02PM -0800, H. Peter Anvin wrote:
> 
>>I was trying to figure out what certain peoples issue with this was,
>>and the answer I got back was concern about buggy hardware (both host
>>side and target side) breaking the documented model.  I am personally
>>in no position to evaluate the veracity of that claim; perhaps you
>>could comment on how to deal with broken hardware in your model.
>>
> 
> And how can we tell if a previous implementation was buggy or if it was 
> actually hardware that was buggy?
> 


There are plenty of known hardware bugs, this is probably a better base 
for discussion...

	-hpa


