Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286517AbSABBUP>; Tue, 1 Jan 2002 20:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286491AbSABBUC>; Tue, 1 Jan 2002 20:20:02 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:45127 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286501AbSABBTv>; Tue, 1 Jan 2002 20:19:51 -0500
Date: Tue, 1 Jan 2002 20:19:50 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
Message-ID: <20020101201950.A11644@redhat.com>
In-Reply-To: <0GPA00BK988OBK@mtaout45-01.icomcast.net> <Pine.LNX.4.10.10201011521190.6558-100000@master.linux-ide.org> <a0tlji$e5m$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a0tlji$e5m$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, Jan 01, 2002 at 04:52:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 04:52:02PM -0800, H. Peter Anvin wrote:
> I was trying to figure out what certain peoples issue with this was,
> and the answer I got back was concern about buggy hardware (both host
> side and target side) breaking the documented model.  I am personally
> in no position to evaluate the veracity of that claim; perhaps you
> could comment on how to deal with broken hardware in your model.

And how can we tell if a previous implementation was buggy or if it was 
actually hardware that was buggy?

		-ben
