Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266927AbSLKBCr>; Tue, 10 Dec 2002 20:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbSLKBCq>; Tue, 10 Dec 2002 20:02:46 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:36104 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266927AbSLKBCY>; Tue, 10 Dec 2002 20:02:24 -0500
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <03c901c2a0b1$a107be50$551b71c3@krlis>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Petr Sebor" <petr@scssoft.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <068d01c29d97$f8b92160$551b71c3@krlis><1039312135.27904.11.camel@irongate.sw ansea.linux.org.uk><20021208234102.GA8293@scssoft.com> <021401c2a05d$f1c72c80$551b71c3@krlis><1039540202.14251.43.camel@irongate.swansea.linux.org.uk> <039d01c2a0ab$b19a5ad0$551b71c3@krlis> <1039569643.14166.105.camel@irongate.swansea.linux.org.uk>
Subject: Re: IDE feature request & problem
Date: Wed, 11 Dec 2002 02:07:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
here is the output. But I don't see any word error :(
    Thanx Milan

$ xfs_repair -n -v /dev/md0
Phase 1 - find and verify superblock...
Phase 2 - using internal log
        - scan filesystem freespace and inode maps...
        - found root inode chunk
Phase 3 - for each AG...
        - scan (but don't clear) agi unlinked lists...
        - process known inodes and perform inode discovery...
        - agno = 0
        - agno = 1
        - agno = 2
        - agno = 3
        - agno = 4
        - agno = 5
        - agno = 6
        - agno = 7
        - agno = 8
        - agno = 9
        - agno = 10
        - agno = 11
        - agno = 12
        - agno = 13
        - agno = 14
        - agno = 15
        - agno = 16
        - agno = 17
        - agno = 18
        - agno = 19
        - agno = 20
        - agno = 21
        - agno = 22
        - agno = 23
        - agno = 24
        - agno = 25
        - agno = 26
        - agno = 27
        - agno = 28
        - agno = 29
        - agno = 30
        - agno = 31
        - agno = 32
        - agno = 33
        - agno = 34
        - agno = 35
        - agno = 36
        - agno = 37
        - agno = 38
        - agno = 39
        - agno = 40
        - agno = 41
        - agno = 42
        - agno = 43
        - agno = 44
        - agno = 45
        - agno = 46
        - agno = 47
        - agno = 48
        - agno = 49
        - agno = 50
        - agno = 51
        - agno = 52
        - agno = 53
        - agno = 54
        - agno = 55
        - agno = 56
        - agno = 57
        - agno = 58
        - agno = 59
        - agno = 60
        - agno = 61
        - agno = 62
        - agno = 63
        - agno = 64
        - agno = 65
        - agno = 66
        - agno = 67
        - agno = 68
        - agno = 69
        - agno = 70
        - agno = 71
        - agno = 72
        - agno = 73
        - agno = 74
        - agno = 75
        - agno = 76
        - agno = 77
        - agno = 78
        - agno = 79
        - agno = 80
        - agno = 81
        - agno = 82
        - agno = 83
        - agno = 84
        - agno = 85
        - agno = 86
        - agno = 87
        - agno = 88
        - agno = 89
        - agno = 90
        - agno = 91
        - agno = 92
        - agno = 93
        - agno = 94
        - agno = 95
        - agno = 96
        - agno = 97
        - agno = 98
        - agno = 99
        - agno = 100
        - agno = 101
        - agno = 102
        - agno = 103
        - agno = 104
        - agno = 105
        - agno = 106
        - agno = 107
        - agno = 108
        - agno = 109
        - agno = 110
        - agno = 111
        - agno = 112
        - agno = 113
        - agno = 114
        - agno = 115
        - agno = 116
        - agno = 117
        - agno = 118
        - agno = 119
        - agno = 120
        - agno = 121
        - agno = 122
        - agno = 123
        - agno = 124
        - agno = 125
        - agno = 126
        - agno = 127
        - agno = 128
        - agno = 129
        - agno = 130
        - agno = 131
        - agno = 132
        - agno = 133
        - agno = 134
        - agno = 135
        - agno = 136
        - agno = 137
        - agno = 138
        - agno = 139
        - agno = 140
        - agno = 141
        - agno = 142
        - agno = 143
        - agno = 144
        - agno = 145
        - agno = 146
        - agno = 147
        - agno = 148
        - agno = 149
        - agno = 150
        - agno = 151
        - agno = 152
        - agno = 153
        - agno = 154
        - agno = 155
        - agno = 156
        - agno = 157
        - agno = 158
        - agno = 159
        - agno = 160
        - agno = 161
        - agno = 162
        - agno = 163
        - agno = 164
        - agno = 165
        - agno = 166
        - agno = 167
        - agno = 168
        - agno = 169
        - agno = 170
        - agno = 171
        - agno = 172
        - agno = 173
        - agno = 174
        - agno = 175
        - agno = 176
        - agno = 177
        - agno = 178
        - agno = 179
        - agno = 180
        - agno = 181
        - agno = 182
        - agno = 183
        - agno = 184
        - agno = 185
        - agno = 186
        - agno = 187
        - agno = 188
        - agno = 189
        - agno = 190
        - agno = 191
        - agno = 192
        - agno = 193
        - agno = 194
        - agno = 195
        - agno = 196
        - agno = 197
        - agno = 198
        - agno = 199
        - agno = 200
        - agno = 201
        - agno = 202
        - agno = 203
        - agno = 204
        - agno = 205
        - agno = 206
        - agno = 207
        - agno = 208
        - agno = 209
        - agno = 210
        - agno = 211
        - agno = 212
        - agno = 213
        - agno = 214
        - agno = 215
        - agno = 216
        - agno = 217
        - agno = 218
        - agno = 219
        - agno = 220
        - agno = 221
        - agno = 222
        - agno = 223
        - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
        - setting up duplicate extent list...
        - check for inodes claiming duplicate blocks...
        - agno = 0
        - agno = 1
        - agno = 2
        - agno = 3
        - agno = 4
        - agno = 5
        - agno = 6
        - agno = 7
        - agno = 8
        - agno = 9
        - agno = 10
        - agno = 11
        - agno = 12
        - agno = 13
        - agno = 14
        - agno = 15
        - agno = 16
        - agno = 17
        - agno = 18
        - agno = 19
        - agno = 20
        - agno = 21
        - agno = 22
        - agno = 23
        - agno = 24
        - agno = 25
        - agno = 26
        - agno = 27
        - agno = 28
        - agno = 29
        - agno = 30
        - agno = 31
        - agno = 32
        - agno = 33
        - agno = 34
        - agno = 35
        - agno = 36
        - agno = 37
        - agno = 38
        - agno = 39
        - agno = 40
        - agno = 41
        - agno = 42
        - agno = 43
        - agno = 44
        - agno = 45
        - agno = 46
        - agno = 47
        - agno = 48
        - agno = 49
        - agno = 50
        - agno = 51
        - agno = 52
        - agno = 53
        - agno = 54
        - agno = 55
        - agno = 56
        - agno = 57
        - agno = 58
        - agno = 59
        - agno = 60
        - agno = 61
        - agno = 62
        - agno = 63
        - agno = 64
        - agno = 65
        - agno = 66
        - agno = 67
        - agno = 68
        - agno = 69
        - agno = 70
        - agno = 71
        - agno = 72
        - agno = 73
        - agno = 74
        - agno = 75
        - agno = 76
        - agno = 77
        - agno = 78
        - agno = 79
        - agno = 80
        - agno = 81
        - agno = 82
        - agno = 83
        - agno = 84
        - agno = 85
        - agno = 86
        - agno = 87
        - agno = 88
        - agno = 89
        - agno = 90
        - agno = 91
        - agno = 92
        - agno = 93
        - agno = 94
        - agno = 95
        - agno = 96
        - agno = 97
        - agno = 98
        - agno = 99
        - agno = 100
        - agno = 101
        - agno = 102
        - agno = 103
        - agno = 104
        - agno = 105
        - agno = 106
        - agno = 107
        - agno = 108
        - agno = 109
        - agno = 110
        - agno = 111
        - agno = 112
        - agno = 113
        - agno = 114
        - agno = 115
        - agno = 116
        - agno = 117
        - agno = 118
        - agno = 119
        - agno = 120
        - agno = 121
        - agno = 122
        - agno = 123
        - agno = 124
        - agno = 125
        - agno = 126
        - agno = 127
        - agno = 128
        - agno = 129
        - agno = 130
        - agno = 131
        - agno = 132
        - agno = 133
        - agno = 134
        - agno = 135
        - agno = 136
        - agno = 137
        - agno = 138
        - agno = 139
        - agno = 140
        - agno = 141
        - agno = 142
        - agno = 143
        - agno = 144
        - agno = 145
        - agno = 146
        - agno = 147
        - agno = 148
        - agno = 149
        - agno = 150
        - agno = 151
        - agno = 152
        - agno = 153
        - agno = 154
        - agno = 155
        - agno = 156
        - agno = 157
        - agno = 158
        - agno = 159
        - agno = 160
        - agno = 161
        - agno = 162
        - agno = 163
        - agno = 164
        - agno = 165
        - agno = 166
        - agno = 167
        - agno = 168
        - agno = 169
        - agno = 170
        - agno = 171
        - agno = 172
        - agno = 173
        - agno = 174
        - agno = 175
        - agno = 176
        - agno = 177
        - agno = 178
        - agno = 179
        - agno = 180
        - agno = 181
        - agno = 182
        - agno = 183
        - agno = 184
        - agno = 185
        - agno = 186
        - agno = 187
        - agno = 188
        - agno = 189
        - agno = 190
        - agno = 191
        - agno = 192
        - agno = 193
        - agno = 194
        - agno = 195
        - agno = 196
        - agno = 197
        - agno = 198
        - agno = 199
        - agno = 200
        - agno = 201
        - agno = 202
        - agno = 203
        - agno = 204
        - agno = 205
        - agno = 206
        - agno = 207
        - agno = 208
        - agno = 209
        - agno = 210
        - agno = 211
        - agno = 212
        - agno = 213
        - agno = 214
        - agno = 215
        - agno = 216
        - agno = 217
        - agno = 218
        - agno = 219
        - agno = 220
        - agno = 221
        - agno = 222
        - agno = 223
No modify flag set, skipping phase 5
Phase 6 - check inode connectivity...
        - traversing filesystem starting at / ...
        - traversal finished ...
        - traversing all unattached subtrees ...
        - traversals finished ...
        - moving disconnected inodes to lost+found ...
Phase 7 - verify link counts...
No modify flag set, skipping filesystem flush and exiting.

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
Cc: "Petr Sebor" <petr@scssoft.com>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Wednesday, December 11, 2002 2:20 AM
Subject: Re: IDE feature request & problem


> On Wed, 2002-12-11 at 00:24, Milan Roubal wrote:
> > Hi Alan,
> > I have got xfs partition and man fsck.xfs say
> > that it will run automatically on reboot.
>
> You need to force one. Something (I assume XFS) asked the disk for a
> stupid sector number. Thats mostly likely due to some kind of internal
> corruption on the XFS
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

